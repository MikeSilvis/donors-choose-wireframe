Project.destroy_all
Challenge.destroy_all
Message.destroy_all
Event.destroy_all

project = FactoryGirl.create(:project)
challenge1 = FactoryGirl.create(:challenge, project: project, amount: 10)

FactoryGirl.create(:message, project: project)
challenge1.mark_as_met
FactoryGirl.create(:message, project: project)
challenge2 = FactoryGirl.create(:challenge, project: project, amount: 20)
FactoryGirl.create(:message, project: project)

