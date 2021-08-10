package linksharing

import grails.gorm.transactions.Transactional
import org.grails.datastore.mapping.query.Projections
import org.hibernate.criterion.AvgProjection
import org.hibernate.criterion.Projection

@Transactional
class ResourceService {

    def serviceMethod() {

    }

//  read service
    def read(User user, int id){
        Resource resource = Resource.findById(id)
        ReadingItem readingItem = ReadingItem.findByUserAndResource(user,resource)

//      new map with updated values
        Map map = ['isRead':true, 'user':user, 'resource': resource, 'id': readingItem.id]
        ReadingItem.executeUpdate('update ReadingItem set isRead=:isRead, user=:user, resource=:resource where id=:id',map)
        return "Resource read"
    }

//  rate service
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
//          new map with updated values
            Map map =['resource':resource,'user':user,'score':score,'id':rating.id]
            ResourceRating.executeUpdate('update ResourceRating set resource=:resource, user=:user, score=:score where id=:id',map)
            return "Resource rated"
        }
    }

//  delete service
    def delete(int id){
        Resource resource = Resource.findById(id)
        ResourceRating ratings = ResourceRating.findAllByResource(resource)

        try{
            ResourceRating.deleteAll(ratings)
            resource.delete(flush:true,failOnError:true)
            return "Resource deleted successfully"
        }catch(Exception e){
            return "Error in deleting the resource"
        }
    }

//  top post service
    def top(){
        List<ResourceRating> list = ResourceRating.createCriteria().list { // getting list of all resources with their average scores
            projections{
                avg("score")
            }
            groupProperty("resource")
        }

        list.sort({ a, b -> a[0] == b[0] ? 0 : a[0] < b[0] ? 1 : -1 }) // sorting the list based on their avg scores
    }
}
