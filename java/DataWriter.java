import java.io.*;

class DataWriter
{
    public DataWriter(DataOutput data_output)
    {
        m_data_output = data_output;
    }

    public int writeBuffer(byte[] buffer)
    {      
        try
        {
            m_data_output.write(buffer, 0, buffer.length);
        }
        catch (IOException e)
        {
            System.out.println("IO Exception Occured");
            return 0;
        }

        return 1;
    }
    
    private DataOutput m_data_output;
}
