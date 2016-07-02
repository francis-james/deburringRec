%Class to draw surface
classdef BoxClass<handle
    
    properties
        fig;
        axs;
        surfPlot;
        x;
        y;
        z;
    end
    
    methods
        function this=BoxClass(x,y,z, fig,axs) 
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
            this.surfPlot=fill3(this.x,this.y,this.z,1,'Parent',this.axs);
        end
        
        function updateState(this,x,y,z)
            this.x=x;
            this.y=y;
            set(this.surfPlot3,'XData',x,'YData',y,'Zdata',z);
            drawnow;
        end
    end
end