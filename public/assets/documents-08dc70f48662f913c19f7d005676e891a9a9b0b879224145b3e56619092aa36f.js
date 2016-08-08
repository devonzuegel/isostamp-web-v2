$(function() {
  $('#s3_uploader').S3Uploader({
    allow_multiple_files:           false,
    progress_bar_target:            $('#uploads-progress-bar'),
    click_submit_target:            $('#submit-upload'),
    remove_completed_progress_bar:  false
  });

  $('#s3_uploader').bind('s3_upload_failed', function (e, content) {
    alert(content.filename + ' failed to upload.');
    setTimeout(function (){ location.reload(); }, 1000);
  });

  $('#s3_uploader').bind('s3_uploads_start', function (e) {
    $('#uploads-progress').show();
  });

  $('#s3_uploader').bind('s3_uploads_complete', function (e) {
    setTimeout(function (){ location.reload(); }, 1500);
  });
});
