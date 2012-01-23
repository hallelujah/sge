module SGE
  class Job
    include SGE::JobHelpers
    define_attributes(
      :JB_job_number => :job_number,
      :JAT_prio => :priority,
      :JB_name => :name,
      :JB_owner => :owner,
      :JAT_start_time => :start_time,
      :queue_name => :queue_name,
      :slots => :slots,
      :state => :state,
      :cpu => :cpu,
      :JB_submission_time => :submission_time
    )

  end
end
