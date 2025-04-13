module ApplicationHelper
  def badge_invite_status(member)
    if member.invitation_accepted_at?
      content_tag(:span, class: "text-xs bg-green-100/50 text-green-800 px-4 py-1 rounded-full border border-green-600 inline-flex items-center gap-x-2") do
        safe_join([ heroicon("check-circle"), " accepted" ])
      end
    else
      content_tag(:span, class: "text-xs bg-yellow-100/50 text-yellow-800 px-4 py-1 rounded-full border border-yellow-600 inline-flex items-center gap-x-2") do
        safe_join([ heroicon("minus-circle"), " pending" ])
      end
    end
  end
end
