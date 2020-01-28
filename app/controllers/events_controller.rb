class EventsController < ApplicationController
  # before_action :require_login, except: %i[index show]

  def index
    @upcoming_events = Event.upcoming.paginate(page: params[:page], per_page: 6)
    @previous_events = Event.previous.paginate(page: params[:page], per_page: 6)
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      @event.attendees << @event.creator
      flash[:success] = 'Successfully created event.'
      redirect_to @event
    else
      flash[:warning] = 'Failed.'
      render 'new'
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def attend
    Event.find_by(id: params[:id]).attendees << current_user
    flash[:success] = 'Attending!'
    redirect_to event_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :location, :date)
  end
end
