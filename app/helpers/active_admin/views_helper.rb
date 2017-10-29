require 'aws-sdk-s3'

module ActiveAdmin::ViewsHelper
  def generate_presigned_url(filename)
    if (!ENV['AWS_ACCESS_KEY_ID'] || !ENV['AWS_SECRET_ACCESS_KEY'] || !ENV['AWS_BUCKET_NAME'])
      raise 'You must set AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY and AWS_BUCKET_NAME in your ' +
            '.env to access this feature.'
    end

    s3 = Aws::S3::Resource.new(region:'us-west-1')
    objKey = DateTime.now.strftime("upload/%Y-%m-%d/%Q-") + filename
    obj = s3.bucket(ENV['AWS_BUCKET_NAME']).object(objKey)
    URI.parse(obj.presigned_url(:put))
  end
end
