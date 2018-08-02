class SignupsController < ApplicationController

  before_action :require_nationbuilder_slug
  before_action :require_email

  def create
    person = $nation_builder_client.call(:people, :push, person: { email: email_param })
    person_id = person['person']['id']
    $nation_builder_client.call(:people, :tag_person, { id: person_id, tagging: { tag: tags_param }} )
    redirect_back flash: { success: 'Thank you for signing up.' }, fallback_location: root_path
  rescue NationBuilder::ClientError => e
    redirect_back flash: { error: JSON.parse(e.message)['validation_errors'][0].capitalize }, fallback_location: root_path
  end

protected

  def require_email
    unless email_param.present?
      redirect_back flash: { error: 'Please enter an email address' }, fallback_location: root_path
    end
  end

  def tags_param
    # returns an array of tags, assuming they're comma-seperated
    params[:tags].to_s.split(',').map(&:strip).select(&:present?)
  end

  def email_param
    params[:email].to_s.downcase.strip
  end
end
