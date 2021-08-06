package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class ResourceService {

    def serviceMethod() {

    }

    def read(User user, int id){
        Resource resource = Resource.findById(id)
        ReadingItem readingItem = ReadingItem.findByUserAndResource(user,resource)

        Map map = ['isRead':true, 'user':user, 'resource': resource, 'id': readingItem.id]

        ReadingItem.executeUpdate('update ReadingItem set isRead=:isRead, user=:user, resource=:resource where id=:id',map)

        return "Resource read"
    }

    def rate(User user, int id, int score){
        Resource resource = Resource.findById(id)
        ResourceRating rating = ResourceRating.findByResourceAndUser(resource,user)

        if(rating == null){
            ResourceRating newRating = new ResourceRating(resource: resource, user: user,score: score)

            try{
                newRating.save(flush:true,failOnError:true)

                return "Resource rated"
            }catch(Exception e){
                println e
            }
        }else{
            Map map =['resource':resource,'user':user,'score':score,'id':rating.id]

            ResourceRating.executeUpdate('update ResourceRating set resource=:resource, user=:user, score=:score where id=:id',map)

            return "Resource rated"
        }
    }
}
