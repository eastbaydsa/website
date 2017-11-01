# Custom input for transparently uploading files to S3.
# Hides the actual text field input in favor of a file selector and an image preview.
# If you use this input, make sure to include attachments.js as well.

class S3UrlInput < Formtastic::Inputs::UrlInput
  def input_html_options
    super.merge(:class => 's3_url_original_input')
  end

  def to_html
    input_wrapping do
      label_html +

      template.content_tag(:table, style: 'display:inline;') do
        template.content_tag :tbody do

          template.content_tag(:tr) {
            template.content_tag :td do
              builder.hidden_field(method, input_html_options) <<
              # file_field_tag requires an ID to be given for some reason. Just make sure
              # it doesn't collide with anything else.
              template.file_field_tag('attachment_' + SecureRandom.hex(4), class: 's3_url_file')
            end
          } +

          template.content_tag(:tr) {
            template.content_tag :td do
              template.image_tag('', class: 's3_url_img', style: 'width:400px;height:auto;') <<
              template.content_tag(:div, 'Uploading... 0%', class: 's3_url_loading')
            end
          }

        end
      end
    end
  end
end
