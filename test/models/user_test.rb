require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:example)
    @another_user = users(:user_1)
    @upcoming_event = @user.created_events.create!(title: 'foo title',
                                                   date: Time.now + 200,
                                                   location: 'foo location')
    @previous_event = @user.created_events.create!(title: 'bar title',
                                                   date: Time.now - 200,
                                                   location: 'bar location')
  end

  test 'should not accept empty name' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'should not accept empty email' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'should return users upcoming events' do
    assert_difference -> { @user.upcoming_events.count }, 1 do
      @user.created_events.create!(title: 'baz title',
                                   date: Time.now + 100,
                                   location: 'baz location')
    end
    assert_includes @user.upcoming_events, Event.last
    assert_includes @user.upcoming_events, @upcoming_event
  end

  test 'should return users previous events' do
    assert_difference -> { @user.previous_events.count }, 1 do
      @user.created_events.create!(title: 'baz title',
                                   date: Time.now - 100,
                                   location: 'baz location')
    end
    assert_includes @user.previous_events, Event.last
    assert_includes @user.previous_events, @previous_event
  end
end
