# Get-CPUTime_byCPU
Nagios Plugin

Tested On
-----
Windows Server 2016
Windows Server 2012R2
Windows Server 2012
Windows Server 2008R2


Usage
-----
1) Copy file into NRPE scripts
2) Edit nsclient.ini. Insert: 

    check_proc_by_cpu=cmd /c echo scripts\\Get-CPUTime.ps1 $ARG1$ $ARG2$; exit $LastExitCode | powershell.exe -noprofile -nologo -command -

3) Create the service on nagions using nrpe command:

create command definitions

    define command {
    command_name        check_nrpe
    command_line        $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$ -a $ARG2$
    }

create service definitions:

    define service {
	.....
    host_name               myhostname
    service_description     CheckCPUTime_byCPU
    check_command           check_nrpe!check_proc_by_cpu!70 80!
    .....
    }

