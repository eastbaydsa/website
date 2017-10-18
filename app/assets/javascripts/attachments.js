$(document).ready(function() {
  // The default caption is misleading, it isn't clear that you can edit
  // field to set your own caption.
  Trix.config.attachments.preview.caption = {
    name: false,
    size: false
  };

  $('.trix-editor-wrapper').on('trix-attachment-add', function(event) {
    var attachment = event.originalEvent.attachment;
    if (attachment.file) {
      uploadAttachment(attachment);
    }
  });
});


function uploadAttachment(attachment) {
  // TODO(bcipriano) This should make a call to the backend to get a
  // presigned URL to upload to. That call will use Heroku config to
  // determine staging vs prod.
  var host = "https://s3-us-west-1.amazonaws.com/ebdsa-attachments-test/";
  var file = attachment.file;
  var key = createStorageKey(file);
  var form = new FormData;
  form.append("key", key);
  form.append("Content-Type", file.type);
  form.append("file", file);

  $.ajax({
    type: 'POST',
    url: host,
    data: form,
    processData: false,
    contentType: false,
    // Custom XHR with upload progress handler added.
    xhr: function(){
      var xhr = $.ajaxSettings.xhr();
      xhr.upload.onprogress = function(event) {
        var progress = event.loaded / event.total * 100;
        return attachment.setUploadProgress(progress);
      };
      return xhr;
    },
    error: function(xhr, textStatus, errorMsg) {
      console.log(errorMsg);
      alert('Failed to upload attachment: ' + textStatus + '. See the console for more detail.');
    },
    success: function(data, msg, xhr){
      var finalUrl = host + key;
      return attachment.setAttributes({
        url: finalUrl,
        href: finalUrl
      });
    }
  });
}


function createStorageKey(file) {
  var date = new Date();
  var day = date.toISOString().slice(0, 10);
  var time = date.getTime();
  return 'upload/' + day + '/' + time + '-' + file.name;
}
