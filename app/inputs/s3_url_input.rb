# Custom input for transparently uploading files to S3.
# If you use this input, make sure to include attachments.js as well.

class S3UrlInput < Formtastic::Inputs::UrlInput
  def to_html

    file_input_cell = template.content_tag :td do
      builder.hidden_field(method, input_html_options) <<
      # file_field_tag requires an ID to be given for some reason. Just make sure
      # it doesn't collide with anything else.
      template.file_field_tag('attachment_' + SecureRandom.hex(4), class: 's3_url_file')
    end

    file_input_row = template.content_tag :tr do
      file_input_cell
    end

    image_preview_cell = template.content_tag :td do
      template.image_tag('', class: 's3_url_img', style: 'width:200px;height:auto;')
    end

    image_preview_row = template.content_tag :tr do
      image_preview_cell
    end

    input_tbody = template.content_tag :tbody do
      file_input_row << image_preview_row
    end

    input_table = template.content_tag :table, style: 'display:inline;' do
      input_tbody
    end

    input_wrapping do
      label_html <<
      input_table
    end

  end
end
