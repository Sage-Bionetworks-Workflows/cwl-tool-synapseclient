from amancevice/pandas

RUN pip3 install synapseclient
RUN pip3 install pandas

RUN wget https://raw.githubusercontent.com/sgosline/synapse-workflow-cwl-tools/master/containers/manifest-merge/join-fileview-by-specimen.py

COPY ./join-fileview-by-specimen.py  /
RUN chmod a+x join-fileview-by-specimen.py
