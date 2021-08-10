package dto

import linksharing.enums.Seriousness
import linksharing.enums.Visibility

class TopicDetailDTO {
    def topicId
    String topicName
    Visibility visibility
    int subsCount
    int postCount
    def creatorId
    String creatorPhoto
    String creatorName
    String creatorUserName
    def subsId
    Seriousness seriousness
    boolean isSubscribed
}
