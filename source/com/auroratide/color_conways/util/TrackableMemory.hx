package com.auroratide.color_conways.util;

/**
 * @author Timothy Foster (tfAuroratide)
 */
interface TrackableMemory {
/**
 *  Returns the number of bytes used by the data structure.
 * 
 *  This is not guaranteed to return the true memory requirement.
 *  The amount returned is only approximate.
 *  @return Amount of memory taken in bytes.
 */
    function memory():Int;
}