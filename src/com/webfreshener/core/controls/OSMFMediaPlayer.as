package com.webfreshener.core.controls
{
	import flash.events.Event;
	
	import mx.core.UIComponent;
	import mx.utils.ObjectUtil;
	
	import org.osmf.events.*;
	import org.osmf.layout.ScaleMode;
	import org.osmf.media.MediaElement;
	import org.osmf.media.MediaPlayer;
	import org.osmf.media.MediaPlayerSprite;
	import org.osmf.media.MediaPlayerState;
	import org.osmf.traits.*;
	
	
	[Event(name="canBufferChange", type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
	[Event(name="canLoadChange", type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
	[Event(name="canPlayChange", type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
	[Event(name="canSeekChange", type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
	[Event(name="hasAudioChange", type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
	[Event(name="hasDisplayObjectChange", type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
	[Event(name="hasDRMChange", type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
	[Event(name="isDynamicStreamChange", type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
	[Event(name="temporalChange", type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
	
	[Event(name="autoSwitchChange", type="org.osmf.events.DynamicStreamEvent")]
	[Event(name="numDynamicStreamsChange", type="org.osmf.events.DynamicStreamEvent")]
	[Event(name="switchingChange", type="org.osmf.events.DynamicStreamEvent")]
	
	[Event(name="bufferingChange", type="org.osmf.events.BufferEvent")]
	[Event(name="bufferTimeChange", type="org.osmf.events.BufferEvent")]
	
	[Event(name="complete", type="org.osmf.events.TimeEvent")]
	[Event(name="currentTimeChange", type="org.osmf.events.TimeEvent")]
	[Event(name="durationChange", type="org.osmf.events.TimeEvent")]
	
	[Event(name="displayObjectChange", type="org.osmf.events.DisplayObjectEvent")]
	[Event(name="mediaSizeChange", type="org.osmf.events.DisplayObjectEvent")]
	
	[Event(name="drmStateChange", type="org.osmf.events.DRMEvent")]
	
	[Event(name="isRecordingChange", type="org.osmf.events.DVREvent")]
	
	[Event(name="bytesLoadedChange", type="org.osmf.events.LoadEvent")]
	[Event(name="bytesTotalChange", type="org.osmf.events.LoadEvent")]
	[Event(name="loadStateChange", type="org.osmf.events.LoadEvent")]
	
	[Event(name="mutedChange", type="org.osmf.events.AudioEvent")]
	[Event(name="panChange", type="org.osmf.events.AudioEvent")]
	[Event(name="volumeChange", type="org.osmf.events.AudioEvent")]
	
	[Event(name="canPauseChange", type="org.osmf.events.PlayEvent")]
	[Event(name="playStateChange", type="org.osmf.events.PlayEvent")]
	
	[Event(name="seekingChange", type="org.osmf.events.SeekEvent")]
	
	[Event(name="mediaError", type="org.osmf.events.MediaErrorEvent")]
	/**
	 * 
	 * @author van
	 * 
	 */	
	public class OSMFMediaPlayer extends UIComponent
	{
		
		private var $sprite:MediaPlayerSprite = new MediaPlayerSprite();
		
		public function get mediaPlayer():MediaPlayer
		{
			return $sprite.mediaPlayer;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set element(value:MediaElement):void
		{
			$sprite.mediaPlayer.media = value;
		}
		
		public function get element():MediaElement
		{
			return $sprite.mediaPlayer.media;
		}
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.CAN_BUFFER_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.CAN_LOAD_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.CAN_PLAY_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.CAN_SEEK_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.HAS_AUDIO_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.HAS_DISPLAY_OBJECT_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.HAS_DRM_CHANGE, redispatchEvent);	
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.IS_DYNAMIC_STREAM_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.TEMPORAL_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(DynamicStreamEvent.AUTO_SWITCH_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(DynamicStreamEvent.NUM_DYNAMIC_STREAMS_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(DynamicStreamEvent.SWITCHING_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(BufferEvent.BUFFER_TIME_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(BufferEvent.BUFFERING_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(TimeEvent.COMPLETE, redispatchEvent);
			mediaPlayer.addEventListener(TimeEvent.CURRENT_TIME_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(TimeEvent.DURATION_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(DisplayObjectEvent.DISPLAY_OBJECT_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(DisplayObjectEvent.MEDIA_SIZE_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(DRMEvent.DRM_STATE_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(DVREvent.IS_RECORDING_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(LoadEvent.BYTES_LOADED_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(LoadEvent.BYTES_TOTAL_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(LoadEvent.LOAD_STATE_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(AudioEvent.MUTED_CHANGE,  redispatchEvent);
			mediaPlayer.addEventListener(AudioEvent.PAN_CHANGE,  redispatchEvent);
			mediaPlayer.addEventListener(AudioEvent.VOLUME_CHANGE,  redispatchEvent);
			mediaPlayer.addEventListener(PlayEvent.CAN_PAUSE_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(PlayEvent.PLAY_STATE_CHANGE, redispatchEvent);
			mediaPlayer.addEventListener(SeekEvent.SEEKING_CHANGE,  redispatchEvent);
			mediaPlayer.addEventListener(MediaErrorEvent.MEDIA_ERROR,  redispatchEvent);
			
			this.addChild( $sprite );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function redispatchEvent(event:Event):void
		{
			//			trace("OSMF player event: "+ObjectUtil.toString(event));
			this.dispatchEvent( event.clone() );
		}
		
		
		override protected function updateDisplayList(w:Number, h:Number):void
		{		
			$sprite.width  = w;
			$sprite.height = h;
		}
		
		
		/**
		 * 
		 * @param value
		 * 
		 
		 public function set scaleMode(value:org.osmf.layout.ScaleMode):void
		 {
		 $sprite.scaleMode = value.toString();
		 }
		 
		 public function get scaleMode():String
		 {
		 return $sprite.scaleMode;
		 }
		 */ 
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set autoRewind(value:Boolean):void
		{			
			mediaPlayer.autoRewind = value;							
		}
		
		public function get autoRewind():Boolean
		{
			return mediaPlayer.autoRewind;
		}
		
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set autoPlay(value:Boolean):void
		{			
			mediaPlayer.autoPlay = value;						
		}
		
		public function get autoPlay():Boolean
		{
			return mediaPlayer.autoPlay;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set loop(value:Boolean):void
		{
			mediaPlayer.loop = value;
		}
		
		public function get loop():Boolean
		{
			return mediaPlayer.loop;
		}
		
		
		
		
		
		
		
		/**
		 * Interval between the dispatches of update progress events for the playhead position
		 * in milliseconds.  The playhead event is org.osmf.events.PlayheadChangeEvent.
		 * <p>The default progress is 250 milliseconds.
		 * A non-positive value disables the dispatch of the update progress events.</p>
		 * <p>The source media element must be temporal in order to support this property.</p>
		 * 
		 * @see org.osmf.traits.ITemporal
		 */
		public function set currentTimeUpdateInterval(milliseconds:Number):void
		{
			mediaPlayer.currentTimeUpdateInterval = milliseconds;
		}
		
		public function get currentTimeUpdateInterval():Number
		{
			return mediaPlayer.currentTimeUpdateInterval;
		}
		
		/**
		 *  MediaPlayer state provides a high level indication of the current operations of the media.
		 *  All states here are not completely disjoint (i.e. initialized + playing have some overlap).
		 */   
		[ChangeEvent(event="mediaPlayerStateChange",type="org.osmf.events.MediaPlayerStateChangeEvent")]	   
		public function get mediaState():String
		{
			return mediaPlayer.state;
		}     
		
		/**
		 *  True when the source mediaElement has the IPlayable trait.
		 */ 	
		[ChangeEvent(event="canPlayChange",type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]			
		public function get canPlay():Boolean
		{
			return mediaPlayer.canPlay;
		}
		
		/**
		 *  True when the source mediaElement has the IPausible trait.
		 */	
		[Event(event="canPauseChange",type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
		public function get canPause():Boolean
		{
			return mediaPlayer.canPause;
		}
		
		/**
		 *  True when the source mediaElement has the ISeekable trait.
		 */
		[ChangeEvent(event="canSeekChange",type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
		public function get canSeek():Boolean
		{
			return mediaPlayer.canSeek;
		}
		
		/**
		 *  True when the source mediaElement has the ITemporal trait.
		 */	
		[ChangeEvent(event="temporalChange",type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
		public function get temporal():Boolean
		{
			return mediaPlayer.temporal;
		}
		
		/**
		 *  True when the source mediaElement has the IAudible trait.
		 */	
		[ChangeEvent(event="audibleChange",type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
		public function get audible():Boolean
		{
			return mediaPlayer.hasAudio;
		}
		
		/**
		 *  True when the source mediaElement has the ISpatial trait.
		 
		 [ChangeEvent(event="viewableChange",type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
		 public function get  viewable():Boolean
		 {
		 return mediaPlayer;
		 }
		 */
		/**
		 *  True when the source mediaElement has the IViewable trait.
		 
		 [ChangeEvent(event="spatialChange",type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
		 public function get  spatial():Boolean
		 {
		 return mediaPlayer;
		 }
		 */
		
		/**
		 *  True when the source mediaElement has the ILoadable trait.
		 */	
		[ChangeEvent(event="canLoadChange",type="org.osmf.events.MediaPlayerCapabilityChangeEvent")]
		public function get canLoad():Boolean
		{
			return mediaPlayer.canLoad;
		}		
		
		
		
		
		
		
		
		
		//-- trait-based props
		/**
		 * The position of the associated media element's cursor 
		 * in seconds.  Must never exceed the <code>duration</code>.
		 */		
		
		[ChangeEvent(event="playheadChange",type="org.osmf.events.PlayheadChangeEvent")]
		public function get playhead():Number
		{
			if (this.canPlay)
				return mediaPlayer.currentTime;
			
			return 0;
		}
		
		/**
		 * The duration of the associated media element in
		 * seconds.
		 */	
		[ChangeEvent(event="durationChange",type="org.osmf.events.DurationChangeEvent")]
		public function get duration():Number
		{
			return (mediaPlayer.temporal) ? mediaPlayer.duration : 0;
		}
		
		[ChangeEvent(event="volumeChange",type="org.osmf.events.VolumeChangeEvent")]
		/**
		 * The volume, ranging from 0 (silent) to 1 (full volume).
		 * 
		 * <p>Passing a value greater than 1 sets the value to 1.
		 * Passing a value less than zero sets the value to zero.
		 * </p>
		 * 
		 * <p>Changing the value of the <code>volume</code> property does not affect the value of the
		 * <code>muted</code> property.</p>
		 * 
		 * <p>The default is 1.</p>
		 * 
		 * @see IAudible#muted 
		 */		
		[ChangeEvent(event="volumeChange",type="org.osmf.events.VolumeChangeEvent")]
		public function get volume():Number
		{			
			return mediaPlayer.hasAudio ?  mediaPlayer.volume : 0;
			return mediaPlayer.volume;
			return mediaPlayer.hasAudio ?  mediaPlayer.volume : 0;
		}
		
		public function set volume(value:Number):void
		{
			mediaPlayer.volume = value;
		}		
		
		
		
		[ChangeEvent(event="panChange",type="org.osmf.events.PanChangeEvent")]
		public function get audioPan():Number
		{			
			return mediaPlayer.hasAudio ?  mediaPlayer.audioPan : 0;
		}
		
		public function set audioPan(value:Number):void
		{
			mediaPlayer.audioPan = value;
		}
		
		
		/**
		 * Indicates whether the media is currently muted.
		 * <p>The source media element must be audible in order to
		 *  support this property.</p>
		 * 
		 * @throws IllegalOperationError if capability isn't supported
		 * @see org.osmf.traits.IAudible
		 */	
		[ChangeEvent(event="muteChange",type="org.osmf.events.MuteChangeEvent")]
		public function get muted():Boolean
		{
			return mediaPlayer.hasAudio ?  mediaPlayer.muted : false;
		}
		
		
		public function set muted(value:Boolean):void
		{
			mediaPlayer.muted = value;
		}
		
		
		
		/**
		 *  True when the source MediaElement is .canBuffer.
		 */	
		public function get canBuffer():Boolean
		{
			return mediaPlayer.canBuffer;
		}
		
		
		
		
		
		
		
		// IPausible
		
		/**
		 * Indicates whether the media is currently paused.
		 * <p>The source media element must be
		 * pausible in order to support this property.</p>
		 * 
		 * @throws IllegalOperationError if capability isn't supported
		 * @see org.openvideomediaPlayer.traits.IPausible
		 */	
		public function get paused():Boolean
		{
			return mediaPlayer.paused;	    		    
		}
		
		/**
		 * Pauses the media, if it is not already paused.
		 * @throws IllegalOperationError if capability isn't supported
		 */
		public function pause():void
		{
			mediaPlayer.pause();	    		
		}
		
		// IPlayable
		
		/**
		 * Indicates whether the media is currently playing.
		 * <p>The source media element must be
		 * playable in order to support this property.</p>
		 * 
		 * @throws IllegalOperationError if capability isn't supported
		 * @see org.osmf.traits.IPlayable
		 */					
		public function get playing():Boolean
		{
			return mediaPlayer.playing;	    		
		}
		
		/**
		 * Plays the media, if it is not already playing.
		 * @throws IllegalOperationError if capability isn't supported
		 */
		public function play():void
		{   	
			if (canPlay)
				mediaPlayer.play();	 	
		}
		
		// ISeekable
		
		/**
		 * Indicates whether the media is currently seeking.
		 * <p>The source media element must be
		 * seekable in order to support this property.</p>
		 * 
		 * @throws IllegalOperationError if capability isn't supported
		 * @see org.osmf.traits.ISeekable
		 */			
		
		public function get seeking():Boolean
		{
			return mediaPlayer.canSeek ? mediaPlayer.seeking : false;
		}
		
		/**
		 * Instructs the playhead to jump to the specified time.
		 * <p>If <code>time</code> is NaN or negative, does not attempt to seek.</p>
		 * @param time Time to seek to in seconds.
		 * @throws IllegalOperationError if capability isn't supported
		 */	    
		public function seek(time:Number):void
		{
			if(mediaPlayer.canSeek)
				mediaPlayer.seek(time);  				
		}
		
		/**
		 * Indicates whether the media is capable of seeking to the
		 * specified time.
		 *  
		 * <p>This method is not bound to the trait's current <code>seeking</code> state. It can
		 * return <code>true</code> while the media is seeking, even though a call to <code>seek()</code>
		 * will fail if a previous seek is still in progress.</p>
		 * 
		 * @param time Time to seek to in seconds.
		 * @return Returns <code>true</code> if the media can seek to the specified time.
		 * @throws IllegalOperationError if capability isn't supported
		 * 
		 */	
		public function canSeekTo(time:Number):Boolean
		{	    		
			return mediaPlayer.canSeek ? mediaPlayer.canSeekTo(time) : false;		
		}
		
		/**
		 * Indicates whether the media is currently buffering.
		 * 
		 * <p>The default is <code>false</code>.</p>
		 * @throws IllegalOperationError if capability isn't supported
		 */		
		
		public function get buffering():Boolean
		{  	
			return canBuffer ? mediaPlayer.buffering : false;	    	
		}
		
		/**
		 * The length of the content currently in the media's
		 * buffer in seconds. 
		 * @throws IllegalOperationError if capability isn't supported
		 */		
		public function get bufferLength():Number
		{    	
			return canBuffer ?  mediaPlayer.bufferLength : 0;	    	
		}
		
		/**
		 * The desired length of the media's buffer in seconds.
		 * 
		 * <p>If the passed value is NaN or negative, it
		 * is coerced to zero.</p>
		 * 
		 * <p>The default is zero.</p> 
		 * @throws IllegalOperationError if capability isn't supported
		 */		
		
		public function get bufferTime():Number
		{	    	
			return canBuffer ? this.mediaPlayer .bufferTime : 0;		    	
		}
		
		public function set bufferTime(value:Number):void
		{
			mediaPlayer.bufferTime = value;	    	
		}
		
		
		
		/*
		private function audibleChanged(event:MediaPlayerCapabilityChangeEvent):void
		{
		dispatchEvent(new VolumeChangeEvent(0, mediaPlayer.volume));
		dispatchEvent(new PanChangeEvent(0, mediaPlayer.pan));
		dispatchEvent(new MutedChangeEvent(mediaPlayer.muted));			
		}
		*/
		
		/*
		protected function onView(event:ViewChangeEvent):void
		{
		if(event.oldView)
		{
		removeChild(event.oldView);
		}
		if(event.newView)
		{				
		addChild(mediaPlayer.view);
		}						
		invalidateDisplayList();			
		}
		*/
		
		
		
		
		public function OSMFMediaPlayer()
		{
			super();
			
			
		}
	}
}