# app/jobs/process_avatar_job.rb
class ProcessAvatarJob < ApplicationJob
  queue_as :default

  def perform(user)
    if user.avatar.attached?
      # Procesar la imagen para redimensionarla
      user.avatar.variant(resize: "50x50").processed
    end
  end
end
