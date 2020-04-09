
---------------
--NOTE - Please do not change this section without understanding the full implications of the secure environment
local _, tbl = ...;

if tbl then
	tbl.SecureCapsuleGet = SecureCapsuleGet;

	local function Import(name)
		tbl[name] = tbl.SecureCapsuleGet(name);
	end

	Import("IsOnGlueScreen");

	if ( tbl.IsOnGlueScreen() ) then
		tbl._G = _G;	--Allow us to explicitly access the global environment at the glue screens
	end

	setfenv(1, tbl);
end
----------------

FrameUtil = {};

function FrameUtil.RegisterFrameForEvents(frame, events)
	for i, event in ipairs(events) do
		frame:RegisterEvent(event);
	end
end

function FrameUtil.UnregisterFrameForEvents(frame, events)
	for i, event in ipairs(events) do
		frame:UnregisterEvent(event);
	end
end

function FrameUtil.RegisterFrameForUnitEvents(frame, events, ...)
	for i, event in ipairs(events) do 
		frame:RegisterUnitEvent(event, ...);
	end
end

function DoesAncestryInclude(ancestry, frame)
	if ancestry then
		local currentFrame = frame;
		while currentFrame do
			if currentFrame == ancestry then
				return true;
			end
			currentFrame = currentFrame:GetParent();
		end
	end
	return false;
end

function GetUnscaledFrameRect(frame, scale)
	local frameLeft, frameBottom, frameWidth, frameHeight = frame:GetScaledRect();
	if frameLeft == nil then
		return 1, 1, 1, 1;
	end

	return frameLeft / scale, frameBottom / scale, frameWidth / scale, frameHeight / scale;
end
