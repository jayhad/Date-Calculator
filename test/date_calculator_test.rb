# @author Jay Gruber
# @author John lee

require 'test/unit'
require_relative '../lib/date_calculator.rb'

class Date_Calculator_Test < Test::Unit::TestCase
  def test_canary
    assert(true, 'Canary')
  end

  def test_output()
  	Date_Calculator.output(@test_output_message, @test_stdout)
  	expected = @test_output_message
		actual = @test_stdout.string.strip
    assert_equal(expected, actual)
  end

 	def test_input()
 		expected = @test_input_message
 		actual = Date_Calculator.input(@test_stdin)
 		assert_equal(expected, actual)
 	end

  def test_is_valid_year()
    expected = false
    actual = Date_Calculator.is_valid_year(@test_low_year)
    assert_equal(expected, actual)

    expected = false
    actual = Date_Calculator.is_valid_year(@test_high_year)
    assert_equal(expected, actual)

    expected = false
    actual = Date_Calculator.is_valid_year(@test_not_int)
    assert_equal(expected, actual)

    expected = true
    actual = Date_Calculator.is_valid_year(@test_valid_year)
    assert_equal(expected, actual)
  end

  def test_is_valid_int()
    expected = false
    actual = Date_Calculator.is_valid_int(@test_not_int)
    assert_equal(expected, actual)

    expected = false
    actual = Date_Calculator.is_valid_int(@test_low_year)
    assert(actual)

    expected = true
    actual = Date_Calculator.is_valid_year(@test_valid_year)
    assert_equal(expected, actual)
  end

  def test_is_valid_month()
    expected = false
    actual = Date_Calculator.is_valid_month(@test_low_month)
    assert_equal(expected, actual)

    expected = false
    actual = Date_Calculator.is_valid_month(@test_high_month)
    assert_equal(expected, actual)

    expected = false
    actual = Date_Calculator.is_valid_month(@test_not_month)
    assert_equal(expected, actual)

    expected = true
    actual = Date_Calculator.is_valid_month(@test_valid_month)
    assert_equal(expected, actual)
  end

  def test_is_valid_day()
    expected = false
    actual = Date_Calculator.is_valid_day(@test_low_day)
    assert_equal(expected, actual)

    expected = false
    actual = Date_Calculator.is_valid_day(@test_high_day)
    assert_equal(expected, actual)

    expected = false
    actual = Date_Calculator.is_valid_day(@test_not_day)
    assert_equal(expected, actual)

    expected = true
    actual = Date_Calculator.is_valid_day(@test_valid_day)
    assert_equal(expected, actual)
  end

  def test_is_valid_date()
    #month = 0 or day = 0 should return false
    expected = false
    actual = Date_Calculator.is_valid_date(2016, 10, 0)
    assert_equal(expected, actual)

    expected = false
    actual = Date_Calculator.is_valid_date(2016, 0, 10)
    assert_equal(expected, actual)
    
    #test an invalid date (Feb 31, here)
    expected = false
    actual = Date_Calculator.is_valid_date(2016, 2, 31)
    assert_equal(expected, actual)

    #test a valid date (Sep 20, 1989 here)
    expected = true
    actual = Date_Calculator.is_valid_date(1989, 9, 20)
    assert_equal(expected, actual)
  end

  def test_get_year()
    #test valid year
    test_out = StringIO.new()
    test_in = StringIO.new(@test_valid_year)
    year = Date_Calculator.get_year(test_out, test_in)

    expected_out = "#{@test_year_prompt}\n#{@test_year_success_msg}#{@test_valid_year}"
    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)

    #test valid year with trailing chars
    test_out = StringIO.new()
    test_in = StringIO.new(@test_valid_year + @test_not_int)
    year = Date_Calculator.get_year(test_out, test_in)

    expected_out = "#{@test_year_prompt}\n#{@test_year_success_msg}#{@test_valid_year}"
    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)

    #test invalid year (lower bound)
    test_out = StringIO.new()
    test_in = StringIO.new("#{@test_low_year}\n#{@test_valid_year}")
    year = Date_Calculator.get_year(test_out, test_in)

    expected_out = "#{@test_year_prompt}\n#{@test_year_retry_prompt}\n#{@test_year_success_msg}#{@test_valid_year}"
    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)

    #test invalid year (upper bound)
    test_out = StringIO.new()
    test_in = StringIO.new("#{@test_high_year}\n#{@test_valid_year}")
    year = Date_Calculator.get_year(test_out, test_in)

    expected_out = "#{@test_year_prompt}\n#{@test_year_retry_prompt}\n#{@test_year_success_msg}#{@test_valid_year}"
    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)

    #test invalid year (not int)
    test_out = StringIO.new()
    test_in = StringIO.new("#{@test_not_int}\n#{@test_valid_year}")
    year = Date_Calculator.get_year(test_out, test_in)

    expected_out = "#{@test_year_prompt}\n#{@test_year_retry_prompt}\n#{@test_year_success_msg}#{@test_valid_year}"
    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)
  end

  def test_get_month()
    #test valid month
    test_out = StringIO.new()
    test_in = StringIO.new(@test_valid_month)
    month = Date_Calculator.get_month(test_out, test_in)

    expected_out = "#{@test_month_prompt}\n#{@test_month_success_msg}#{@test_valid_month}"
    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)

    #test valid month with trailing chars
    test_out = StringIO.new()
    test_in = StringIO.new(@test_valid_month + @test_not_int)
    month = Date_Calculator.get_month(test_out, test_in)

    expected_out = "#{@test_month_prompt}\n#{@test_month_success_msg}#{@test_valid_month}"
    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)

    #test invalid month (lower bound)
    test_out = StringIO.new()
    test_in = StringIO.new("#{@test_low_month}\n#{@test_valid_month}")
    month = Date_Calculator.get_month(test_out, test_in)

    expected_out = "#{@test_month_prompt}\n#{@test_month_retry_prompt}\n#{@test_month_success_msg}#{@test_valid_month}"
    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)

    #test invalid month (upper bound)
    test_out = StringIO.new()
    test_in = StringIO.new("#{@test_high_month}\n#{@test_valid_month}")
    month = Date_Calculator.get_month(test_out, test_in)

    expected_out = "#{@test_month_prompt}\n#{@test_month_retry_prompt}\n#{@test_month_success_msg}#{@test_valid_month}"
    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)

    #test invalid month (not int)
    test_out = StringIO.new()
    test_in = StringIO.new("#{@test_not_int}\n#{@test_valid_month}")
    month = Date_Calculator.get_month(test_out, test_in)

    expected_out = "#{@test_month_prompt}\n#{@test_month_retry_prompt}\n#{@test_month_success_msg}#{@test_valid_month}"
    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)
  end

  def test_get_day()
    #test valid day
    test_out = StringIO.new()
    test_in = StringIO.new(@test_valid_day)
    day = Date_Calculator.get_day(test_out, test_in)

    expected_out = "#{@test_day_prompt}\n#{@test_day_success_msg}#{@test_valid_day}"
    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)

    #test valid day with trailing chars
    test_out = StringIO.new()
    test_in = StringIO.new(@test_valid_day + @test_not_int)
    day = Date_Calculator.get_day(test_out, test_in)

    expected_out = "#{@test_day_prompt}\n#{@test_day_success_msg}#{@test_valid_day}"
    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)

    #test invalid day (lower bound)
    test_out = StringIO.new()
    test_in = StringIO.new("#{@test_low_day}\n#{@test_valid_day}")
    day = Date_Calculator.get_day(test_out, test_in)

    expected_out = "#{@test_day_prompt}\n#{@test_day_retry_prompt}\n#{@test_day_success_msg}#{@test_valid_day}"
    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)

    #test invalid day (upper bound)
    test_out = StringIO.new()
    test_in = StringIO.new("#{@test_high_day}\n#{@test_valid_day}")
    day = Date_Calculator.get_day(test_out, test_in)

    expected_out = "#{@test_day_prompt}\n#{@test_day_retry_prompt}\n#{@test_day_success_msg}#{@test_valid_day}"
    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)

    #test invalid day (not int)
    test_out = StringIO.new()
    test_in = StringIO.new("#{@test_not_int}\n#{@test_valid_day}")
    day = Date_Calculator.get_day(test_out, test_in)

    expected_out = "#{@test_day_prompt}\n#{@test_day_retry_prompt}\n#{@test_day_success_msg}#{@test_valid_day}"
    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)
  end

  def test_get_date()
    #test valid date
    test_out = StringIO.new()
    test_in = StringIO.new("#{@test_valid_year}\n#{@test_valid_month}\n#{@test_valid_day}")
    date = Date_Calculator.get_date(test_out, test_in)

    expected_year_out = "#{@test_year_prompt}\n#{@test_year_success_msg}#{@test_valid_year}"
    expected_month_out = "#{@test_month_prompt}\n#{@test_month_success_msg}#{@test_valid_month}"
    expected_day_out = "#{@test_day_prompt}\n#{@test_day_success_msg}#{@test_valid_day}"
    expected_out = "#{expected_year_out}\n#{expected_month_out}\n#{expected_day_out}\n#{@test_date_success_msg}"

    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)
    test_date = Date.new(@test_valid_year.to_i, @test_valid_month.to_i, @test_valid_day.to_i)
    assert_equal(test_date, date)

    #test invalid date
    test_out = StringIO.new()
    test_in = StringIO.new("#{@test_invalid_date}\n#{@test_valid_year}\n#{@test_valid_month}\n#{@test_valid_day}")
    date = Date_Calculator.get_date(test_out, test_in)

    expected_valid_out = expected_out
    expected_year_out = "#{@test_year_prompt}\n#{@test_year_success_msg}#{@test_valid_year}"
    expected_month_out = "#{@test_month_prompt}\n#{@test_month_success_msg}2"
    expected_day_out = "#{@test_day_prompt}\n#{@test_day_success_msg}31"
    expected_retry_out = "#{expected_year_out}\n#{expected_month_out}\n#{expected_day_out}\n#{@test_date_retry_prompt}"
    expected_out = "#{expected_retry_out}\n#{expected_valid_out}"

    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)
    test_date = Date.new(@test_valid_year.to_i, @test_valid_month.to_i, @test_valid_day.to_i)
    assert_equal(test_date, date)
  end

  def test_app()
    #test valid date
    test_out = StringIO.new()
    test_in = StringIO.new("#{@test_valid_year}\n#{@test_valid_month}\n#{@test_valid_day}")
    Date_Calculator.app(test_out, test_in)

    expected_year_out = "#{@test_year_prompt}\n#{@test_year_success_msg}#{@test_valid_year}"
    expected_month_out = "#{@test_month_prompt}\n#{@test_month_success_msg}#{@test_valid_month}"
    expected_day_out = "#{@test_day_prompt}\n#{@test_day_success_msg}#{@test_valid_day}"
    expected_dow_out = "#{@test_dow_success_msg}#{@test_expected_dow}"
    expected_out = "#{@test_app_prompt}\n#{expected_year_out}\n#{expected_month_out}\n#{expected_day_out}\n#{@test_date_success_msg}\n#{expected_dow_out}"

    actual_out = test_out.string.strip
    assert_equal(expected_out, actual_out)
  end

 	def setup()
 		@test_stdout = StringIO.new()
 		@test_output_message = "what is 2 + 2?"
 		@test_input_message = "the answer is 4"
 		@test_stdin = StringIO.new(@test_input_message)
    @test_low_year = "1888"
    @test_high_year = "2020"
    @test_not_int = "ABCDE"
    @test_low_month = "0"
    @test_high_month = "13"
    @test_low_day = "0"
    @test_high_day = "32"
    @test_valid_year = "1989"
    @test_valid_month = "9"
    @test_valid_day = "20"
    @test_year_prompt = "Please enter the 4-digit year of your birth"
    @test_year_success_msg = "Year accepted: "
    @test_year_retry_prompt = "Try again. The year must be 4 digits between 1899 and now"
    @test_month_prompt = "Please enter the numerical month of your birth"
    @test_month_success_msg = "Month accepted: "
    @test_month_retry_prompt = "Try again. The month must be 1 or 2 digits between 1 and 12"
    @test_day_prompt = "Please enter the numerical day of your birth"
    @test_day_success_msg = "Day accepted: "
    @test_day_retry_prompt = "Try again. The day must be 1 or 2 digits between 1 and 31"
    @test_date_retry_prompt = "Try again. The date you entered is not a valid calendar date"
    @test_dow_success_msg = "You were born on a: "
    @test_expected_dow = "Wednesday"
    @test_date_success_msg = "Date accepted: 1989-09-20"
    @test_invalid_date = "1989\n02\n31"
    @test_app_prompt = "Hello. I can tell you what day of the week you were born on!"
 	end
end