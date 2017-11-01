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
      uploadFile(attachment.file, function(progress) {
        return attachment.setUploadProgress(progress);
      }, function(url) {
        return attachment.setAttributes({ url: url, href: url });
      });
    }
  });

  $('.s3_url').each(function(i, form_element) {
    setupS3UrlField($(form_element));
    refreshImagePreview($(form_element));
  });
});


function setupS3UrlField($form_element) {
  $form_element.find('.s3_url_loading').hide()
  $form_element.find('.s3_url_file').on('change', function() {
    var file = $(this)[0].files[0];
    if (file) {
      $form_element.find('.s3_url_img').hide();
      updateUploadProgressDisplay($form_element, 0);
      $form_element.find('.s3_url_loading').show();
      uploadFile(file, function(progress) {
        updateUploadProgressDisplay($form_element, progress);
      }, function(url) {
        $form_element.find('.s3_url_original_input').val(url);
        var newImage = new Image();
        newImage.onload = function() {
          $form_element.find('.s3_url_loading').hide();
          refreshImagePreview($form_element);
        }
        newImage.src = url;
      });
    }
  });
}


function updateUploadProgressDisplay($form_element, progress) {
  $form_element.find('.s3_url_loading').text('Uploading... ' + parseInt(progress) + '%');
}


function refreshImagePreview($form_element) {
  var imgUrl = $form_element.find('.s3_url_original_input').val();
  if (imgUrl) {
    $form_element.find('.s3_url_img').attr('src', imgUrl).show();
  }
}


function uploadFile(file, progressCallback, successCallback) {
  $.get('/admin/admins/get_presigned_url?filename=' + file.name, {}, function(uploadUrl) {
    $.ajax({
      type: 'PUT',
      url: uploadUrl,
      data: file,
      processData: false,
      contentType: false,
      error: function(xhr, textStatus, errorMsg) {
        console.log(errorMsg);
        alert('Failed to upload file: ' + textStatus + '. See the console for more detail.');
      },
      xhr: function() {
        var xhr = $.ajaxSettings.xhr();
        xhr.upload.onprogress = function(event) {
          var progress = event.loaded / event.total * 100;
          return progressCallback(progress);
        };
        return xhr;
      },
      success: function(data, msg, xhr) {
        // Strip off the signing token and other params to leave the plain URL.
        return successCallback(uploadUrl.substring(0, uploadUrl.lastIndexOf('?')));
      }
    });
  });
}

