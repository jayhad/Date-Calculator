# @author Jay Gruber
# @author John lee

require 'date'

#just a convenience mix-in to make getting the weekday easier
#returns same result as date.strftime(%A)
class Date
  def dayname
     DAYNAMES[self.wday]
  end
end

module Date_Calculator
	def self.output(output_message, stdout = $stdout)
		stdout.puts output_message
	end

	def self.input(stdin = $stdin)
        stdin.gets.chomp
    end

    def self.is_valid_year(year)
    	year = (if is_valid_int(year) then year.to_i else 0 end)
    	if (1899..Date.today.year).include? year then true else false end
    end

    def self.is_valid_month(month)
    	month = (if is_valid_int(month) then month.to_i else 0 end)
    	if (1..12).include? month then true else false end
    end

    def self.is_valid_day(day)
    	day = (if is_valid_int(day) then day.to_i else 0 end)
    	if (1..31).include? day then true else false end
    end

    #really checks is valid non-zero int
    #acceptable for this purpose. 0 is not a valid mon, day, or year.
    def self.is_valid_int(string)
    	if string.to_i == 0 then false else true end
    end

    def self.is_valid_date(year, month, day)
        valid = true
        begin
            date = Date.new(year, month, day)
        rescue ArgumentError
            valid = false
        end
        valid
    end

    def self.get_year(stdout = $stdout, stdin = $stdin)
        prompt = "Please enter the 4-digit year of your birth"
        retry_prompt = "Try again. The year must be 4 digits between 1899 and now"
        success_msg = "Year accepted: "

        output(prompt, stdout)
        input = input(stdin)

        until(is_valid_year input)
            output(retry_prompt, stdout)
            input = input(stdin)
        end

        input = input.to_i
        output(success_msg + input.to_s, stdout)
        input
    end

    def self.get_month(stdout = $stdout, stdin = $stdin)
        prompt = "Please enter the numerical month of your birth"
        retry_prompt = "Try again. The month must be 1 or 2 digits between 1 and 12"
        success_msg = "Month accepted: "

        output(prompt, stdout)
        input = input(stdin)

        until(is_valid_month input)
            output(retry_prompt, stdout)
            input = input(stdin)
        end
        
        input = input.to_i
        output(success_msg + input.to_s, stdout)
        input
    end

    def self.get_day(stdout = $stdout, stdin = $stdin)
        prompt = "Please enter the numerical day of your birth"
        retry_prompt = "Try again. The day must be 1 or 2 digits between 1 and 31"
        success_msg = "Day accepted: "

        output(prompt, stdout)
        input = input(stdin)

        until(is_valid_day input)
            output(retry_prompt, stdout)
            input = input(stdin)
        end
        
        input = input.to_i
        output(success_msg + input.to_s, stdout)
        input
    end

    def self.get_date(stdout = $stdout, stdin = $stdin)
        year = get_year(stdout, stdin)
        month = get_month(stdout, stdin)
        day = get_day(stdout, stdin)
        retry_prompt = "Try again. The date you entered is not a valid calendar date"
        success_msg = "Date accepted: "

        until( is_valid_date(year, month, day) )
            output(retry_prompt, stdout)
            year = get_year(stdout, stdin)
            month = get_month(stdout, stdin)
            day = get_day(stdout, stdin)
        end

        date = Date.new(year, month, day)
        output(success_msg + date.to_s, stdout)
        date
    end

    def self.app(stdout = $stdout, stdin = $stdin)
        welcome_msg = "Hello. I can tell you what day of the week you were born on!"
        success_msg = "You were born on a: "
        output(welcome_msg, stdout)
        date = get_date(stdout, stdin)
        output(success_msg + date.dayname, stdout)
    end
end