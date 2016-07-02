%Class to draw surface
classdef PlaneClass<handle
    
    properties
        fig;
        axs;
        surfPlot;
        x;
        y;
        z;
        clrindex;
    end
    
    methods
        function this=PlaneClass(x,y,z, clrindex,fig,axs) 
            if ~exist('fig','var')
                this.fig=figure();
            else 
                this.fig=fig;
            end
            
            if ~exist('axs','var')
                this.axs=axs;
            else
                this.axs=gca;
            end
            this.x=x;
            this.y=y;
            this.z=z;
            this.clrindex=clrindex;
            this.surfPlot=fill3(this.x,this.y,this.z,this.clrindex,'Parent',this.axs);
        end
        
        function updateState(this,x,y,z)
            this.x=x;
            this.y=y;
            this.z=z;
            set(this.surfPlot,'XData',x,'YData',y,'Zdata',z);
            drawnow;
        end
    end
end