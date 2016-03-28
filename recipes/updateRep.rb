if node[:platform_family].include?("rhel")
    bash 'update_for_apache_2.4' do
      user 'root'
      cwd '/etc/yum.repos.d/'
      code <<-EOH
      wget http://repos.fedorapeople.org/repos/jkaluza/httpd24/epel-httpd24.repo
      yum -y install httpd24.x86_64
      EOH
    end
end