       program annnegd2
       dimension idisarr(300),irecarr(1000),ireclen(150),iswarr(250)
       goto 110
       open (unit=3,file='modjlen',access='direct',form=&
       'formatted',recl=600,status='old')
       read (3,1005,rec=1)(ireclen(jf),jf=1,79)
       print *,'reclen',(ireclen(jf),jf=1,120)
       stop


1005   format (1000i4)       
       open (unit=1,file='discrim',access='direct',form=&
       'formatted',recl=965,status='old')
       open (unit=2,file='modjpol',access='sequential')
       iccc=0
       iddd=0
200    iccc=iccc+1   
       limt=ireclen(iccc)
       read (2,*,end=400)(irecarr(jf),jf=1,limt)
       if (irecarr(3).ne.4)goto 201
       iddd=iddd+1
       print *,'irecarr',(irecarr(jf),jf=1,limt)
       print *,'recno',irecarr(1),'disc',irecarr(2),'deg',irecarr(3),iccc
201    goto 200
400    close (unit=2)       
       print *,'iccc=',iccc,'iddd',iddd
       stop
       read (1,1001,rec=1)icont,(idisarr(jf),jf=1,120)
       print *,'discrims',(idisarr(jf),jf=1,icont)
       close (unit=1)
       stop
1001   format(i5,120i8)
       do i=1,240
       idisarr(i)=0
       iswarr(i)=0
       end do
110    a=a       
       do i=1,240
       idisarr(i)=0
       end do
       idis=7
       
       icont=0
55     ddis=idis
       rtd3=sqrt(ddis/3)
       irtd3=rtd3
       isw=0
       iib=mod(idis,2)
       iit=(iib*iib+idis)/4
       iia=iib
       idegm=1
2      if (iia.le.1)goto 1
3      if (mod(iit,iia).ne.0)goto 20
       print *,'iit',iit,'iia',iia,'iib',iib
!       goto 112
       ibig=abs(iit/iia)
       little=abs(iia)
       call subbw2(ibig,little,igcd2)
       if ((igcd2.ne.1).and.(iib.eq.0))goto 20
       if (iib.eq.0)goto 112
       ibig=igcd2
       little=abs(iib)
       call subbw2(ibig,little,igcd2)
       if (igcd2.ne.1)goto 20
112    a=a 


       
       if (iia.eq.iib)goto 6
       if (iia*iia.eq.iit)goto 6
       if (iib.eq.0)goto 6
       goto 10
6      idegn=1
       idegm=idegm+idegn
       goto 20
1      iia=1
       goto 20
63     iit=(iib*iib+idis)/4
       iia=iib
       goto 2
10     idegn=2
       idegm=idegm+idegn
       isw=isw+1
20     iia=iia+1
       if (iia*iia.le.iit)goto 3
       iib=iib+2
       if (iib.le.irtd3)goto 63
       print *,'class no. primitive forms only=',idegm ,'for d=-',idis
!       stop
       if (idegm.ne.4)goto 49
!       if (isw.eq.0)goto 49
       icont=icont+1
       iswarr(icont)=isw
       idisarr(icont)=idis
49     if (idis.eq.2000)goto 100
       if (mod(idis,4).eq.0)goto 50
       idis=idis+1
       goto 55
50     idis=idis+3
       goto 55
100    print *,'total no of discriminants whose class is 4al =',icont       
!       write (1,1001,rec=1)icont,(idisarr(jf),jf=1,120)
       if (icont.eq.0)goto 205
       print *,'discrims',(idisarr(jf),jf=1,icont)
       print *,'conj. count',(iswarr(jf),jf=1,icont)
205    end
      subroutine subbw2(ibig,little,igcd2)
918   itemp=int(ibig/little)
      irem1=ibig-itemp*little
      if (irem1.eq.0)goto 940
      ibig=little
      little=irem1
      
      goto 918
940   igcd2=little
      return
      end


