class CrudNotificationMailer < ApplicationMailer

  def create_notification(object)
    @object = object
    mail to:'admin@gmail.com' , subject:"A new entry for #{object.class} has been created."

  end

  def update_notification

  end

  def delete_notification

  end
end
