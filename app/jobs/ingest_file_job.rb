require File.join(Gem::Specification.find_by_name("hyrax").full_gem_path, "app/jobs/ingest_file_job.rb")

class IngestFileJob < ActiveJob::Base
  alias_method :monkey_perform, :perform

  # @param [FileSet] file_set
  # @param [String] filepath the cached file within the Hyrax.config.working_path
  # @param [User] user
  # @option opts [String] mime_type
  # @option opts [String] filename
  # @option opts [String] relation, ex. :original_file
  def perform(file_set, filepath, user, opts = {})
    # begin
    Rails.logger.debug "About to call IngestFileJob.perform(#{filepath})"
    #monkey_perform(file_set, filepath, user, opts)
    CharacterizationHelper.ingest( file_set, filepath, user, opts )
    CharacterizeJob.perform_later(file_set, repository_file.id, filepath)
    Rails.logger.debug "Returned from call to IngestFileJob.perform(#{filepath})"
  rescue Exception => e
    Rails.logger.error "IngestFileJob.perform(#{file_set},#{filepath},#{user}) #{e.class}: #{e.message}"
  end

end