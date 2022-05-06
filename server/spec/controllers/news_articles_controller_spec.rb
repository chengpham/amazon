require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do
    describe '#new' do
        context "with signed in user" do
            before do
                session[:user_id]=FactoryBot.create(:user)
            end
            it 'render the new template' do
                get(:new)
                expect(response).to(render_template(:new)) 
            end
            it 'sets an instance variable with new job posts' do
                get(:new)
                expect(assigns(:news_article)).to(be_a_new(NewsArticle))
            end
        end 
        context 'with user not signed in'do
            it 'should redirect to sign in page' do
                get(:new)
                expect(response).to redirect_to(new_session_path)
            end
        end
    end
    describe '#create' do
        def valid_request
            post(:create, params:{news_article: FactoryBot.attributes_for(:news_article)})
        end
        context 'with user signed in' do
            before do
                session[:user_id]=FactoryBot.create(:user)
            end
            context " with valid parameter " do 
                it 'creates a job post in the database' do
                    count_before = NewsArticle.count
                    valid_request
                    count_after=NewsArticle.count
                    expect(count_after).to(eq(count_before + 1))
                end
                it 'redirects us to a show page of that post' do
                    valid_request
                    news_article=NewsArticle.last
                    expect(response).to(redirect_to(news_article_url(news_article.id)))
                end
            end
            context 'with invalid parameters' do
                def invalid_request
                    post(:create, params:{news_article: FactoryBot.attributes_for(:news_article, title: nil)})
                end
                it 'doesnot save a record in the database'do
                    count_before = NewsArticle.count
                    invalid_request
                    count_after = NewsArticle.count
                    expect(count_after).to(eq(count_before))
                end
                it 'renders the new template' do
                    invalid_request
                    expect(response).to render_template(:new)
                end
            end
        end
        context 'with user not signed in'do
            it 'should redirect to sign in page' do
                valid_request
                expect(response).to redirect_to(new_session_path)
            end
        end
    end
    describe '#show' do
        it 'render show template' do
            news_article=FactoryBot.create(:news_article)
            get(:show, params:{id: news_article.id})
            expect(response).to render_template(:show)
        end
        it 'set an instance variable @news_article for the shown object' do
            news_article=FactoryBot.create(:news_article)
            get(:show, params:{id: news_article.id})
            expect(assigns(:news_article)).to(eq(news_article))
            
        end
    end
    describe '#index' do 
        it 'render the index template' do
            get(:index)
            expect(response).to render_template(:index)
        end
        it 'assign an instance variable @news_articles which contains all created job posts' do
            news_article_1=FactoryBot.create(:news_article)
            news_article_2=FactoryBot.create(:news_article)
            news_article_3=FactoryBot.create(:news_article)
            get(:index)
            expect(assigns(:news_articles)).to eq([news_article_3, news_article_2,news_article_1])
        end
    end
    describe "# edit" do
        context "with signed in user" do
            context " as owner" do
                before do
                    current_user=FactoryBot.create(:user)
                    session[:user_id]= current_user.id
                    @news_article=FactoryBot.create(:news_article, user: current_user)
                end
                it "render the edit template" do
                    get(:edit, params:{id: @news_article.id})
                    expect(response).to render_template :edit
                end
            end
            context 'as non owner' do
                before do
                    current_user=FactoryBot.create(:user)
                    current_user2=FactoryBot.create(:user)
                    session[:user_id]= current_user.id
                    @news_article=FactoryBot.create(:news_article, user: current_user2)
                end
                it 'should redirect to the show page' do
                    get(:edit, params:{id: @news_article.id})
                    expect(response).to redirect_to news_article_path(@news_article.id)
                end
            end
        end
    end
    describe '#update' do
        before do 
            @news_article= FactoryBot.create(:news_article)
        end
        context "with signed in user"do
            before do
                session[:user_id]=FactoryBot.create(:user)
            end
            context "with valid parameters" do
                it "update the job post record with new attributes" do
                    new_title = "#{@news_article.title} plus some changes!!!"
                    patch(:update, params:{id: @news_article.id, news_article: {title: new_title}})
                    expect(@news_article.reload.title).to(eq(new_title))
                end
                it 'redirect to the show page' do
                    new_title = "#{@news_article.title} plus some changes!!!"
                    patch(:update, params:{id: @news_article.id, news_article: {title: new_title}})
                    expect(response).to redirect_to(@news_article)
                end
            end
            context "with invalid parameters" do
                it 'should not update the job post record' do
                    patch(:update, params:{id: @news_article.id, news_article: {title: nil}})
                    news_article_after_update = NewsArticle.find(@news_article.id)
                    expect(news_article_after_update.title).to(eq(@news_article.title))
                end
            end
        end
    end
    describe '#destroy' do
        context "with signed in user" do
            context 'as owner' do
                before do
                    current_user=FactoryBot.create(:user)
                    session[:user_id]=current_user.id
                    @news_article=FactoryBot.create(:news_article, user: current_user)
                    delete(:destroy, params:{id: @news_article.id})
                end
                it 'remove news article from the db' do
                    expect(NewsArticle.find_by(id: @news_article.id)).to(be(nil))
                end
                it 'redirect to the news article index' do
                    expect(response).to redirect_to(news_articles_path)
                end
                it 'set a flash message' do
                    expect(flash[:danger]).to be
                end 
            end
            context "as non owner" do
                before do
                    current_user = FactoryBot.create(:user)
                    session[:user_id]=current_user.id
                    @news_article=FactoryBot.create(:news_article)
                end
                it 'does not remove the job post' do
                    delete(:destroy,params:{id: @news_article.id})
                    expect(NewsArticle.find(@news_article.id)).to eq(@news_article)
                end
            end
        end
    end
end
