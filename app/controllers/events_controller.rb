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
      flash[:success] = 'Successfully created event.'
      redirect_to event_path(@event)
    else
      flash[:warning] = 'Failed.'
      render 'events/new'
    end
  end

  # def show
  def attendee
    @event = Event.find_by(id: params[:event_id])
    @users = User.All
    @attendees = Attendee.where(event_id: params[:event_id])
  end

  def attendance
    attendee = Attendee.new(user_id: params['user_id'], event_id: params['event_id'])

    if attendee.save
      flash[:success] = 'Attending!'
    else
      flash[:danger] = 'Try again.'
    end

    redirect_to attendee_path(event_id: params['event_id'])
  end

  private

  def event_params
    params.require(:event).permit(:title, :location, :date)
  end
end
