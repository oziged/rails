module ApplicationHelper
    def created_or_updated item
        if item.created_at == item.updated_at
            "created : #{item.created_at.localtime.strftime('%d %b | %H:%M:%S')}"
        else
            "updated : #{item.updated_at.localtime.strftime('%d %b | %H:%M:%S')}"
        end
    end
end
