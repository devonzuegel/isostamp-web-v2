class UploadDocument < Que::Job
  def run(document_params)
    @document = Document.new(document_params)
    puts "AFTER -----------------".black
    ap document_params
    # ap @document

    if @document.save
      puts "#{@document.filename} saved successfully!".green
    else
      puts @document.errors.full_messages.join("\n").red
    end

    destroy
  end
end