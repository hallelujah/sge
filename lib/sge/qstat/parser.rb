require 'nokogiri'
module SGE
  module QStat
    class Parser < Nokogiri::XML::Document
      XPATH_JOB_LIST = '//job_list'
      XPATH_PENDING = '//job_list[@state="pending"]'
      XPATH_RUNNING = '//job_list[@state="running"]'
      XPATH_SUSPENDED = '//job_list[@state="suspended"]'

      def parse(*args)
        reset!
        super
      end

      def jobs
        @jobs ||=  xpath(XPATH_JOB_LIST)
      end

      def pending_jobs
        @pending_jobs ||= xpath(XPATH_PENDING)
      end

      def running_jobs
        @running_jobs ||=  xpath(XPATH_RUNNING)
      end
      
      def suspended_jobs
        @suspended_jobs ||= xpath(XPATH_SUSPENDED)
      end

      def reset!
        @jobs = nil
        @running_jobs = nil
        @pending_jobs = nil
      end
      
    end
  end
end
