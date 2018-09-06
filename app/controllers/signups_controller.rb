class SignupsController < ApplicationController
  before_action :require_nationbuilder_slug
  before_action :require_email

  def create
    person = $nation_builder_client.call(:people, :push, person: person_params.to_h)
    person_id = person['person']['id']
    $nation_builder_client.call(:people, :tag_person, { id: person_id, tagging: { tag: page_form_tags }} )
    redirect_back flash: { success: 'Thank you for signing up.' }, fallback_location: root_path
  rescue NationBuilder::ClientError => e
    error = JSON.parse(e.message)['validation_errors'][0].capitalize rescue nil
    error ||= JSON.parse(e.message)['message']
    redirect_back flash: { error: error }, fallback_location: root_path
  end

protected

  def require_email
    unless person_params[:email].present?
      redirect_back flash: { error: 'Please enter an email address' }, fallback_location: root_path
    end
  end

  def page_form_tags
    # pull tags for this signup from the Page object
    blacklist = ['national_member'] # tags that aren't allowed via a signup form
    if params[:page_id].present?
      page = Page.find params[:page_id]
      page.form_tags.to_s.split(',').map(&:strip).select(&:present?) - blacklist
    end
  end

  def person_params
    person = params.fetch(:person, {}).permit :email, :mobile
    person[:email] = person[:email].downcase.strip if person[:email].present?
    person[:mobile] = person[:mobile].gsub(/[^0-9]/, '') if person[:mobile].present?
    person
  end
end
