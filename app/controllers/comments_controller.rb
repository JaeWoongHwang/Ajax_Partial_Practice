class CommentsController < ApplicationController
  def create
    # 요청에서 들어오는 URL 파라미터 변수에서 :post_id를 획득하여 Post를 조회하고
    @post = Post.find(params[:post_id])
    # 그 모델이 가지는 Comments의 관계를 연결하여 이것을 저장
    @comment = @post.comments.build(comment_params)

    if @comment.save
      # Ajax를 사용하기 때문에 컨트롤러가 뷰를 응답할 때, JavaScript로 응답하도록 한다.
      # 이 때 format.js로 지정한 뷰의 응답은 create 메소드의 이름과 동일한 JavaScript 파일로 app/views/comments/create.js.erb 라는 이름의 파일과 매핑된다
      respond_to do |format|
        format.js
      end
    else

    end
  end

  def destroy
   @comment = Comment.find(params[:id])
   if @comment.destroy
     respond_to do |format|
       format.js
     end
   end
  end
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
