module AresMUSH
  module PenTraits
    class AddJobCheckRequestHandler
      def handle(request)
        job = Job[request.args[:id]]
        char_name = request.args[:pc_name] || ""
        enactor = request.enactor

        error = Website.check_login(request)
        return error if error

        request.log_request

        if (char_name != "")
           char = Character.find_one_by_name(char_name)
           if (!char)
             return { error: t('webportal.not_found') }
           end
        else
           char = enactor
        end

        if (!job)
          return { error: t('webportal.not_found') }
        end

        if (!Jobs.can_access_job?(enactor, job, true))
          return { error: t('jobs.cant_view_job') }
        end

        if (!job.is_open?)
          return { error: t('jobs.job_already_closed') }
        end

        result = PenTraits.determine_web_check_result(request, char, enactor)

        return result if result[:error]

        Jobs.comment(job, Game.master.system_character, result[:message], false)

        {
        }
      end
    end
  end
end
