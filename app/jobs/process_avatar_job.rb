# frozen_string_literal: true

# ProcessAvatarJob is a background job responsible for handling avatar-related
# processing tasks. This job is enqueued in the default queue and is designed
# to perform actions related to user avatars asynchronously.
#
# Example tasks might include resizing avatar images, applying image
# transformations, or processing image uploads. The specific implementation
# of these tasks would be defined in the `perform` method.
class ProcessAvatarJob < ApplicationJob
  queue_as :default

  # Executes the job's task. This method should be implemented to define
  # the actions to be performed when the job is processed.
  #
  # @param args [Array] Optional arguments passed to the job when it is enqueued.
  def perform(*args)
    # Do something later
  end
end
