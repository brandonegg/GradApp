require 'spec_helper'
require 'rails_helper'

describe Education do
  before(:each) do
    @sample_student = {
      first_name: 'Brandon',
      last_name: 'Egger',
      email: 'beggr@uiowa.edu',
      phone: '3196408865',
      dob: Date.new,
      status: 'submitted'
    }
    @sample_application = GraduateApplication.create!(@sample_student)
    @sample_education = {
      school_name: 'University of Iowa',
      state_date: Date.parse('4-22-2019'),
      end_date: Date.new,
      currently_attending: false,
      degree: 'Bachelors',
      major: 'Computer Science',
      gpa: '3.58',
      gpa_scale: '4.0'
    }
  end
  describe 'creating an education object for an application' do
    context 'with all required fields' do
      it 'should create an education object for the associated application' do
        @sample_application.educations.create!(@sample_education)
        expect(@sample_application.save).to be_truthy
      end
    end
    context 'with invalid start and end dates' do
      it 'should be invalid' do
        @sample_education[:start_date] = Date.parse('4-22-2019')
        @sample_education[:end_date] = Date.parse('4-21-2019')
        @sample_application.educations.build(@sample_education)
        expect(@sample_application.save).to be_falsey
      end
    end
    context 'with missing parameters' do
      it 'should be invalid' do
        @sample_application.educations.build
        expect(@sample_application.save).to be_falsey
      end
    end
    context 'with invalid GPA' do
      it 'should raise an argument error' do
        @sample_education[:gpa] = 3.14
        @sample_education[:gpa_scale] = 3.11
        expect(@sample_application.save).to be_falsey
      end
    end
  end
  describe 'modeling education data' do
    context 'when valid gpa present' do
      it 'should return formatted GPA ratio' do
        @education = @sample_application.educations.create!(@sample_education)
        expect(@education.gpa_ratio).to eq 0.895
      end
    end
  end
  describe 'parent modifications' do
    context 'associated graduate application is deleted' do
      it 'should also delete all associated reviews' do
        @education = @sample_application.educations.create!(@sample_education)
        @education_id = @education.id
        expect { Education.find(@education_id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end