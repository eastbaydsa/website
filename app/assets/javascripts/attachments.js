$(document).ready(function() {
  // The default caption is misleading, it isn't clear that you can edit
  // the field to set your own caption. Remove the default, which fills
  // in a much nicer "Add a caption..." message.
  Trix.config.attachments.preview.caption = {
    name: false,
    size: false
  };

  // This will fire when any file is drag-and-dropped on the editor.
  $('.trix-editor-wrapper').on('trix-attachment-add', function(event) {
    var attachment = event.originalEvent.attachment;
    if (attachment.file) {
      uploadAttachment(attachment);
    }
  });
});


function uploadAttachment(attachment) {
  var file = attachment.file;

  $.get('/admin/admins/get_presigned_url?filename=' + file.name, {}, function(uploadUrl) {
    $.ajax({
      type: 'PUT',
      url: uploadUrl,
      data: file,
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
        // Strip off the signing token and other params to leave the plain URL.
        var finalUrl = uploadUrl.substring(0, uploadUrl.lastIndexOf('?'));
        return attachment.setAttributes({
          url: finalUrl,
          href: finalUrl
        });
      }
    });
  }, 'text');
}

