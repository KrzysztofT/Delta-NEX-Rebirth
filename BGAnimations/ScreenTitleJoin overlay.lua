--[[
Apparently the IdleTimeout doesn't call a transition, so we have to work
around it by checking the timer and executing the transition before the timer runs out
]]
local timerSeconds = THEME:GetMetric("ScreenTitleJoin", "IdleTimeoutSeconds");
local fadeoutTime = .3;

return Def.ActorFrame{

	--Piggybacking off that...
	--LoadActor("ScreenTitleMenu decorations")..{};
	
	--[[LoadActor(THEME:GetPathS("ScreenTitleMenu", "music"))..{
		OnCommand=function(self)
			if PREFSMAN:GetPreference("AttractSoundFrequency") == 'AttractSoundFrequency_EveryTime' then
				self:play();
			end
		end;
		OffCommand=cmd(stop);
	};]]
	
	Def.Quad{
		InitCommand=cmd(Center;setsize,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,Color("Black");diffusealpha,0;draworder,999);
		--Doesn't work, input gets locked during a transition.
		--[[OnCommand=function(self)
			if timerSeconds > 0 then
				SCREENMAN:GetTopScreen():AddInputCallback(inputs);
				self:hibernate(timerSeconds-fadeoutTime);
				self:queuecommand("Fade");
			end
		end;]]
		--[[OnCommand=function(self)
			--SCREENMAN:GetTopScreen():AddInputCallback(inputs);
			SCREENMAN:SystemMessage(PREFSMAN:GetPreference("AttractSoundFrequency"));
		end;]]
		
		FadeCommand=cmd(linear,fadeoutTime;diffusealpha,1);
	};
	
		
	Def.Quad{
		InitCommand=function(self)
			self:setsize(SCREEN_WIDTH,50):diffuse(Color("Black")):Center();
			if PREFSMAN:GetPreference("MemoryCardProfiles") == true and PROFILEMAN:GetNumLocalProfiles() > 0 then
			
			else
				self:visible(false);
			end;
		end;
	};
	
	LoadFont("soms2/_soms2 techy")..{
		--TODO: Localize this
		Text="You have USB saving enabled, but you still have local profiles.\nYou need to delete all local profiles to use USB saving.";
		InitCommand=function(self)
			self:Center();
			--[[if PREFSMAN:PreferenceExists("MemoryCardProfiles") then
				self:settext(tostring(PREFSMAN:GetPreference("MemoryCardProfiles")));
			else
				self:settext("false");
			end;]]
			--Although it's 1 or 0 in the preferences.ini, it's a boolean when ingame.
			if PREFSMAN:GetPreference("MemoryCardProfiles") == true and PROFILEMAN:GetNumLocalProfiles() > 0 then
				--Do nothing
			else
				self:visible(false);
			end;
		end;
	};
	
	LoadFont("venacti/_venacti_outline 26px bold diffuse")..{
		Text="Insert a USB flash drive to save progress";
		InitCommand=cmd(diffuseshift;effectperiod,2;effectcolor1,color("1,1,1,1");effectcolor2,color("1,1,1,0");xy,SCREEN_CENTER_X,SCREEN_BOTTOM-75;zoom,.75;visible,PREFSMAN:GetPreference("MemoryCardProfiles"));
	};

};
