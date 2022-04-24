FROM ubuntu:18.04 AS build 
RUN apt update && apt install unzip -y && mkdir /nop 
ADD https://github.com/nopSolutions/nopCommerce/releases/download/release-4.50.2/nopCommerce_4.50.2_NoSource_linux_x64.zip /nop/nopCommerce_4.50.2_NoSource_linux_x64.zip 
RUN cd /nop && unzip nopCommerce_4.50.2_NoSource_linux_x64.zip  && rm nopCommerce_4.50.2_NoSource_linux_x64.zip 

FROM mcr.microsoft.com/dotnet/aspnet:5.0
EXPOSE 80 
COPY --from=build /nop /nop-new 
CMD ["dotnet", "/nop-new/Nop.Web.dll"]