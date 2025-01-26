class UsersController < ApplicationController
    skip_before_action :check_approval, only: :waiting_approval
  
    def waiting_approval
    end
  end
  