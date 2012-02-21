module SGE
  module QStat
    class Job
      include SGE::JobHelpers
      define_attributes(
        :JB_name => :name,
        :JB_job_number => :job_number,
        :JB_owner => :owner,
        :JAT_start_time => :start_time,
        :queue_name => :queue_name,
        :JB_submission_time => :submission_time
      )
      special_attribute :state, "@state|state"

      def self.load_documents(opts,&block)
        documents = []

        # Make a fifo to dump file
        fifo = opts[:file] || SGE::Utils.mkfifo(opts[:tmp_dir])

        # Compute command
        cmd = command(opts.merge(:fifo => fifo))

        # Execute this command
        SGE::Utils.execute(cmd)

        # We need a XML parser

        # Read file from fifo and instantiate jobs
        SGE::Utils.read_file(fifo, true) do |file|
          # Parse the file
          doc = SGE::QStat::Parser.parse(file)
          # Loop through the jobs found
          doc.jobs.each do |j|
            if block_given?
              documents << yield(self.from_document(j))
            else
              documents << self.from_document(j)
            end
          end
        end
        documents
      end

      def self.command(opts)
        if opts[:cmd]
          stat = File.stat(opts[:fifo])
          [opts[:cmd],">", opts[:fifo], stat.pipe? ? "&" : nil].join(' ')
        else
          file = opts[:sample] || File.expand_path('../../../../spec/data/qstat.sge',__FILE__)
          "cat #{file} > #{opts[:fifo]} &"
        end
      end

    end
  end
end
