include ActionView::Helpers::DateHelper

class LectureTimer

  attr_reader :start_time, 
  :start_time_string,
  :lock_time, 
  :lock_time_string, 
  :total_time, 
  :time_remaining, 
  :time_remaining_percent, 
  :time_remaining_string

  def initialize(lecture)
    @lecture = lecture
    calculate_time_remaining
    format_times
  end

  private

  def calculate_time_remaining
    @start_time = get_start_time
    @lock_time = (@start_time + 24.hour).end_of_day
    
    @total_time = @lock_time - @start_time
    @time_remaining = get_time_remaining
  end

  def get_start_time
    @lecture.created_at > @lecture.finish_time ? @lecture.created_at : @lecture.finish_time
  end

  def get_time_remaining
    time_remaining = (@lock_time - Time.now).to_i
    time_remaining > 0 ? time_remaining : 0
  end

  def get_time_remaining_percent
    ((@time_remaining.to_f / @total_time.to_f) * 100.0).to_i
  end

  def get_time_remaining_string
    distance_of_time_in_words(@lock_time, Time.now) if time_remaining > 0
  end

  def format_times
    # Format is "Sunday, 5:35 PM"
    @start_time_string = @start_time.strftime("%A, %l:%M %p")
    @lock_time_string = @lock_time.strftime("%A, %l:%M %p")

    @time_remaining_percent = get_time_remaining_percent
    @time_remaining_string = get_time_remaining_string
  end

end