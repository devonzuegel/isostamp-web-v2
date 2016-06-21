class UploadResultsFileToS3 < Que::Job
  def run(results_file_id)
    @results_file = ResultsFile.find(results_file_id)
    puts "Running results_file ##{results_file_id} [#{@results_file.filename}]...  QueJob.count = #{QueJob.count}".green

    if @results_file.upload_complete?
      raise ArgumentError, "Upload is already complete for ResultsFile with id #{results_file_id}"
    end

    direct_upload_url = upload_to_s3
    remove_tmp_file(@results_file.tmp_filepath)

    ActiveRecord::Base.transaction do
      @results_file.update_attributes(direct_upload_url: direct_upload_url)
      # TODO delete tmp_file from ./tmp directory
      destroy
    end
  end

  private

  def upload_to_s3
    puts "Uploading #{@results_file.s3_key} to s3...".blue
    file = s3_bucket.object(@results_file.s3_key)
    file.upload_file(@results_file.tmp_filepath, acl: 'public-read')
    file.public_url
  end

  def s3_bucket
    @s3 ||= Aws::S3::Resource.new(
      credentials:  Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
      region:       ENV['AWS_BUCKET_REGION']
    )
    @s3.bucket(ENV['AWS_S3_BUCKET'])
  end

  def remove_tmp_file(filepath)
    puts "Removing tmp file '#{filepath}'...".blue
    stdin, stdout, stderr = Open3.popen3("rm #{filepath};")
  end
end