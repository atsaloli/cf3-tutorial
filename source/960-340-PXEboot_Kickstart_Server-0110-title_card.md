## PXEboot Kickstart Server

The following is a demonstration of integrating CFEngine in the host provisioning process so that installation of the OS is followed immediately by installation of the CFEngine agent package and configuration of the host.

I used to bring two laptops to my trainings; one of them was configured (via CFEngine) as a PXEboot server and a Kickstart server; I would reboot the other laptop and let it boot off the NIC (PXEboot).  The victim would get a fresh OS + the CFEngine policies. 

An production system engineer who kindly reviewed these materials wrote breathlessly:

> Aleksey, I came across a script that does pxe boot setup using cfengine ?
> really ??
> this is awesome !

He explained:

> I use cobbler to do pxe installation. but the cfengine script looks straight forward. also, as mentioned in the cfengine docs, the entire knowledge of pxe setup is present in the "*.cf" file. I just looked at and realized that this is called knowledge management. 
>
> in case of cobbler knowledge is scattered in 
>
> 1. cobbler tool setup (which contains all service setup)
> 
> 2. manual setup by user (turning off firewall and selinux)
> 
> 3. kickstart files
>
> all these are present in one *.cf file. this is super awesome ! 
>
>--M.

Yes, CFEngine (especially its the Knowledge Management aspect) is "super awesome"!

The following was last tested a couple of years ago on CentOS 5.  It may need an update.
