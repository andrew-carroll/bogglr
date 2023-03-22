class RatsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  def edit
    @rat = Rat.find(params[:id])
    if @rat == nil
      flash[:error] = "This rat does not exist."
      redirect_to root_path
    end
  end

  def update
    @rat = Rat.find(params[:id])
    if @rat.caretakers.include?(current_user)
      if @rat.update(rat_params)
        redirect_to @rat
      else
        render :edit
      end
    else
      flash[:error] = "You are not authorized to edit this rat."
      redirect_to user_profile_path
    end
  end

  def create
    @rat = current_user.rats.new(rat_params)
    if @rat.save
      redirect_to rat_path(@rat)
    else
      flash[:error] = "There was a problem adding this rat. Please try again."
      render :new
    end
  end

  def new
  end

  def show
    @rat = Rat.find(params[:id])
    if @rat == nil
      flash[:error] = "This rat does not exist."
      redirect_to root_path
    end
  end

  private

  def rat_params
    params.require(:rat).permit(:name, :approx_birthday, :sex, :crossed_rainbow_bridge_at)
  end
end
