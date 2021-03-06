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
    its('stdout') { should include ('7.65') }
  end
end

control 'python version' do
  impact 1.0
  title 'confirm python version installed'
  desc 'confirm version reported by python matches the desired version'
  describe command('python3 -V') do
    its('stdout') { should include ('3.7') }
  end
end

control 'python packages' do
  impact 1.0
  title 'confirm python package installation'
  desc 'confirm all desired python packages are installed'
  describe command('pip list') do
    its('stdout') { should include ('setuptools') }
    its('stdout') { should include ('invoke') }
    its('stdout') { should include ('yamllint') }
  end
end

control 'invoke version' do
  impact 1.0
  title 'confirm invoke version installed'
  desc 'confirm version reported by invoke matches the desired version'
  describe command('invoke -V') do
    its('stdout') { should include ('1.3') }
  end
end

control 'yamllint version' do
  impact 1.0
  title 'confirm yamllint version installed'
  desc 'confirm version reported by yamllint matches the desired version'
  describe command('yamllint -v') do
    its('stdout') { should include ('1.17') }
  end
end

control 'circleci-cli version' do
  impact 1.0
  title 'confirm circleci-cli version installed'
  desc 'confirm version reported by circleci-cli matches the desired version'
  describe command('circleci version') do
    its('stdout') { should include ('0.1.5') }
  end
end
