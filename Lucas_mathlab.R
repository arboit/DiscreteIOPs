# lambda=[380 395 412 443 465 490 510 532 555 560 589 625 665 683 694 710 765 780 975];
# limit_depth=[0.5:0.1:5];
# 
# for i=1:length(lambda)
# Ed0_eval=limit_depth.*nan;
# for k=1:length(limit_depth)
# L=(LuZDepthm<=limit_depth(k)) & (LuZDepthm>=0.1);
# z_upper=LuZDepthm(L);
# Lu_upper=Lu(L,i);
# Ed0_upper=Ed0(L,i);
# EdZ_upper=EdZ(L,i);
# L=~isnan(z_upper)&~isnan(EdZ_upper)&Lu_upper>0;
# if sum(L)>=5
# p=polyfit(z_upper(L),log(squeeze(EdZ_upper(L))),1 );
# Ed0m_test=exp(p(1).*0.0001 + p(2));
# Ed0p_test=nanmean(Ed0(L,i));
# % the cat jumps here because it adjust accorind the better depth to fit!
#   Ed0_eval(k)= abs(Ed0m_test - 0.97.*Ed0p_test);
# end
# end
# if sum(~isnan(Ed0_eval))>0
# [Y,posi] = min(abs(Ed0_eval));
# L=(LuZDepthm<=limit_depth(posi)) & (LuZDepthm>=0.1);
# z_upper=LuZDepthm(L);
# Lu_upper=Lu(L,i);
# Ed0_upper=Ed0(L,i);
# EdZ_upper=EdZ(L,i);
# L=~isnan(z_upper)&~isnan(EdZ_upper)&Lu_upper>0;;
# p=polyfit(z_upper(L),log(squeeze(EdZ_upper(L))),1 );
# % Ed0-
#   EdZ0(n_cast,i)=exp(p(1).*0.0001 + p(2));     
# z_profile=[0:0.1:5];
# EdZ_profile(:,i)=exp(p(1).*z_profile + p(2));
# Ed0p(n_cast,i)=nanmedian(Ed0_upper(L));
# 
# L=~isnan(z_upper)&~isnan(Lu_upper)&Lu_upper>0;
# p=polyfit(z_upper(L),log(Lu_upper(L)),1 );
# Lu0=exp(p(1).*0.0001 + p(2));
# 
# z_profile=[0:0.1:5];
# Lu0_profile(:,i)=exp(p(1).*z_profile + p(2));
# 
# 
# Lw0=0.543.* Lu0;
# Rrs(n_cast,i)= Lw0./nanmedian(Ed0_upper);
# else
#   Rrs(n_cast,i)=nan;
# z_profile=[0:0.1:5];
# Lu0_profile(:,i)=z_profile.*nan;
# end
# end
# [a,b]=size(EdZ0);
# Rrs_Mueller2003=lambda.*nan;
# L= abs(1-(EdZ0./Ed0p))<0.05;
# for i=1:length(lambda)
# if sum(L(:,i))<1&a>1
# [Y,I]=min(abs(EdZ0-Ed0p));
# Rrs_Mueller2003(i)=Rrs(I(i),i);
# else
#   Rrs_Mueller2003(i)=nanmean(Rrs(L(:,i),i));
# end
# end