class LectureTimer

  attr_reader :start_time, :lock_time, :time_remaining

  def initialize(lecture)
    @lecture = lecture
    calculate_time_remaining
    format_times
  end

  private

  def calculate_time_remaining
    @start_time = get_start_time
    @lock_time = (@start_time + 24.hour).end_of_day
    @time_remaining = @lock_time - @start_time
  end

  def get_start_time
    @lecture.created_at > @lecture.finish_time ? @lecture.created_at : @lecture.finish_time
  end

  def format_times
    # Format is "Sunday, 5:35 PM"
    @start_time = @start_time.strftime("%A, %l:%M %p")
    @lock_time = @lock_time.strftime("%A, %l:%M %p")
  end

end