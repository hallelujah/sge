module SGE
  module QStat
    class Job
      include SGE::JobHelpers
      define_attributes(
        :JB_name => :name,
        :JB_job_number => :job_number,
        :JAT_start_time => :start_time,
        :queue_name => :queue_name,
        :JB_submission_time => :submission_time,
        :state => :state
      )
    end
  end
end
