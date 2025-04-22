module AresMUSH
  module PenTraits
    class AddSceneCheckRequestHandler
      def handle(request)
        scene = Scene[request.args['id']]
        enactor = request.enactor
        sender_name = request.args['sender']
        
        error = Website.check_login(request)
        return error if error

        request.log_request
        
        sender = Character.named(sender_name)
        if (!sender)
          return { error: t('webportal.not_found') }
        end
        
        if (!AresCentral.is_alt?(sender, enactor))
          return { error: t('dispatcher.not_allowed') }
        end
        
        if (!scene)
          return { error: t('webportal.not_found') }
        end
        
        if (!Scenes.can_read_scene?(enactor, scene))
          return { error: t('scenes.access_not_allowed') }
        end
        
        if (scene.completed)
          return { error: t('scenes.scene_already_completed') }
        end
        
        result = PenTraits.determine_web_check_result(request, sender, enactor)
        
        return result if result[:error]

        Achievements.award_achievement(sender, "trait_check")
        PenTraits.emit_results(result[:message], scene.room)
        
        {
        }
      end
    end
  end
end
