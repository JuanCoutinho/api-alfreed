class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted? && !resource.approved?
        flash[:notice] = "Your account has been created and is awaiting approval by an admin."
      end
    end
  end
end
