json.merge! task.attributes
json.comments task.comments, partial: 'api/comments/comment', as: :comment