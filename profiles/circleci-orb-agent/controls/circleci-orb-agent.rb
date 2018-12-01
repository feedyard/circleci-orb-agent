control 'packages' do
  impact 1.0
  title 'confirm package installation'
  desc 'confirm all desired packages are installed'
  describe command('apk info') do
    its('stdout') { should include ('curl') }
    its('stdout') { should include ('python3') }
  end
end

control 'curl version' do
  impact 1.0
  title 'confirm curl version installed'
  desc 'confirm version reported by curl matches the desired version'
  describe command('curl -V') do
    its('stdout') { should include ('7.6') }
  end
end

control 'python version' do
  impact 1.0
  title 'confirm python version installed'
  desc 'confirm version reported by python matches the desired version'
  describe command('python3 -V') do
    its('stdout') { should include ('3.6') }
  end
end

control 'python packages' do
  impact 1.0
  title 'confirm python package installation'
  desc 'confirm all desired python packages are installed'
  describe command('pip list') do
    its('stdout') { should include ('invoke') }
    its('stdout') { should include ('pytest') }
  end
end

control 'invoke version' do
  impact 1.0
  title 'confirm invoke version installed'
  desc 'confirm version reported by invoke matches the desired version'
  describe command('invoke -V') do
    its('stdout') { should include ('1.2') }
  end
end

# control 'pytest version' do
#   impact 1.0
#   title 'confirm pytest version installed'
#   desc 'confirm version reported by pytest matches the desired version'
#   describe command('pytest --version') do
#     its('stdout') { should include ('4.0') }
#   end
# end

control 'circleci-cli version' do
  impact 1.0
  title 'confirm circleci-cli version installed'
  desc 'confirm version reported by circleci-cli matches the desired version'
  describe command('circleci version') do
    its('stdout') { should include ('0.1.4280') }
  end
end